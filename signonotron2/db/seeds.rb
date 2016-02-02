def log(str)
  Rails.logger.info "[#{Time.now.utc}] #{str}"
end

log "-- Seeding database"

if ENV["ADMIN_EMAIL"].present?
  User.where(email: ENV["ADMIN_EMAIL"]).first_or_initialize.tap do |user|
    if user.new_record?
      password = SecureRandom.hex
      user.password = password
      user.name = "superadmin"
      log "Creating user #{ENV["ADMIN_EMAIL"]} / #{password}"
    end
    user.update! role: "superadmin"
    user.confirm!
  end
end

log "-- done"
