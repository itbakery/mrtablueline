class ApproveSystem
    include Sidekiq::Worker
    def perform(id,path,classname)
      @obj = classname.constantize.where(id: id).first
      NotificationsMailer.new_message(@obj).deliver
    end
end
