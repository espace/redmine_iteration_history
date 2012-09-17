require_dependency 'version'
module VersionPatch
  def self.included(base)
    base.send(:extend,ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      has_many :iteration_histories,:dependent=>:delete_all
      after_save :create_history
      attr_accessor :change_reason
    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def create_history
      if self.changed? && self.changes['effective_date']
        logger.info "*********************************************************************************************************"
        tmp = self.inspect
        logger.info tmp
        logger.info "############################################################################################################"
        self.iteration_histories.create!(:old_due_date=>self.changes['effective_date'][0],
                                         :new_due_date=>self.effective_date,
                                         :reason=>self.change_reason)
      end
    end
  end
end

