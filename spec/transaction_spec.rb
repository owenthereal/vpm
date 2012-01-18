require 'spec_helper'

describe Transaction do
  context "#perform" do
    before do
      @transaction = Transaction.new
      @task_one = double "Task One"
      @task_two = double "Task Two"
      @transaction << @task_one
      @transaction << @task_two
    end

    it 'runs each task when the transaction is peformed' do
      @task_one.should_receive("perform").and_return true
      @task_two.should_receive("perform").and_return true
      @transaction.perform
    end

    it 'undoes every task that has been run so far if any of them return false' do
      @task_one.should_receive("perform").and_return true
      @task_one.should_receive "undo"
      @task_two.should_receive("perform").and_return false
      @task_two.should_receive "undo"
      @transaction.perform
    end

    it 'skips any tasks following a failing one' do
      @task_one.should_receive("perform").and_return false
      @task_one.should_receive "undo"
      @task_two.should_not_receive "peform"
      @transaction.perform
    end

    it 'undoes the tasks in the opposite order they were performed' do
      @transaction = Transaction.new
      result = []
      @task_one = Object.new
      @task_two = Object.new
      @task_one.define_singleton_method "perform" do true end
      @task_one.define_singleton_method "undo"    do result << "task one" end
      @task_two.define_singleton_method "perform" do false end
      @task_two.define_singleton_method "undo"    do result << "task two" end
      @transaction << @task_one
      @transaction << @task_two
      @transaction.perform
      result.should == ["task two", "task one"]
    end

    it 'undoes all of the tasks if one raises an execption' do
      @task_one.should_receive("perform").and_return true
      @task_one.should_receive "undo"
      @task_two.should_receive("perform") { raise "an error" }
      @task_two.should_receive "undo"
      expect { @transaction.perform }.to raise_error
    end

    it 'rethrows exceptions raised by a task' do
      @task_one.should_receive("perform").and_return true
      @task_one.should_receive "undo"
      @task_two.should_receive("perform") { raise "an error" }
      @task_two.should_receive "undo"
      expect { @transaction.perform }.to raise_error
    end
  end
end
