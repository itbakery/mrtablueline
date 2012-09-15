  module  Log
    def class_type
      "This class is of type: #{self.class}"
    end
    def history

    end
    def refresh_version
      unless User.current_user.nil?
      self.versions = "by #{User.current_user.name}:" + Time.now.strftime("Edit on %m/%d/%Y at %I:%M%p")
      end
    end
    def report_bymail
      self.updated_at  > 10.minutes.ago
    end
    def report_bysms
    end
  end
