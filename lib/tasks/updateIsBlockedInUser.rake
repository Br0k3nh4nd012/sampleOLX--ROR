namespace :updateIsBlockedInUser do
    desc "isBlocked boolean column is updated for all user"

    task :initializeIsBlocked => :environment do
        User.update_all(isBlocked: false)
    end
    task :uninitializeIsBlocked => :environment do
        User.update_all(isBlocked: nil)
    end
end