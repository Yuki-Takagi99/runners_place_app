module SelectDateHelpers
	def select_date(date, options = {})
    field = options[:from]
    base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for]
    year, month, day = date.split(',')
    select year,  :from => "#{base_id}_1i"
    select month, :from => "#{base_id}_2i"
    select day,   :from => "#{base_id}_3i"
  end

  def select_time(hour, minute, second, options = {})
    field = options[:from]
    base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for]
    select hour, :from => "#{base_id}_4i"
		select minute, :from => "#{base_id}_5i"
		select second, :from => "#{base_id}_6i"
	end
end