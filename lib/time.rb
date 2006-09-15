class Time
  def to_sql
    "to_timestamp('" + formatted + "', 'YYYY-MM-DD HH24:MI:SS')"
  end
  
  protected
  
  def formatted
    "#{year.to_s}-#{pad(month)}-#{pad(day)} #{pad(hour)}:#{pad(min)}:#{pad(sec)}"
  end
  
  def pad(num)
    num.to_s.rjust(2,'0')
  end
end