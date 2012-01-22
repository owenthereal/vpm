class VPM::Commands::Setup::Transaction
  def initialize
    @tasks = []
  end

  def <<(task)
    @tasks << task
  end

  def tasks
    @tasks
  end

  def perform
    completed_tasks = []
    @tasks.each do |task|
      completed_tasks.unshift task
      unless task.perform
        completed_tasks.each &:undo
        break
      end
    end
  rescue Exception => e
    completed_tasks.each &:undo
    raise
  end
end
