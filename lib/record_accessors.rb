require "record_accessors/version"

module RecordAccessors

  def self.included(base)
    base.class_eval do
      class << self
        def available_attributes
          @available_attributes ||= []
        end

        alias_method :attr_accessor_without_tracking, :attr_accessor
        def attr_accessor(*names)
          available_attributes.concat(names)
          attr_accessor_without_tracking(*names)
        end
      end
    end
  end

  def hash_from_attributes
    self.class.available_attributes.inject({}) do |h, key|
      h[key] = self.send(key)
      h
    end
  end

  def initialize_from_attributes(attrs = {})
    attrs.each do |name, value|
      if respond_to?("#{name}=")
        send("#{name}=", value)
      end
    end
  end

end
