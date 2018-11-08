class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Dynamically removes white space of input fields. Called using before_save in needed models.
  def remove_whitespace
    attribute_names.each do |name|
      if send(name).respond_to?(:strip)
        send("#{name}=", send(name).strip)
      end
    end
  end
end
