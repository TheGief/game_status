module SessionsHelper
  def cleanup_old_sessions
    # Sessions inactive for 24hrs are deleted
    ActiveRecord::SessionStore::Session.delete_all(["updated_at < ?", 24.hours.ago])
  end
end