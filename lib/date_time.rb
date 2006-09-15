require 'date'

module DateTimeExtension
  def to_sql
    "to_timestamp('" + formatted + "', 'YYYY-MM-DD HH24:MI:SS')"
  end
  
  def to_pretty_datetime
    self.strftime("%m-%d-%Y %I:%M %p")
  end

  private 
  
  def formatted
    year.to_s + "-" + month.pad + "-" + day.pad + " " + hour.pad + ":" + min.pad + ":" + sec.pad
  end
end

DateTime.send :include, DateTimeExtension