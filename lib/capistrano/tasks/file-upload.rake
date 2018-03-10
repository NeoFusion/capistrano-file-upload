namespace :file_upload do
  desc 'Check required files and dirs'
  task :check do
    invoke 'file_upload:check:dirs'
    invoke 'file_upload:check:files'
  end

  namespace :check do
    desc 'Check required dirs exists'
    task :dirs do
      next unless any? :file_upload_dirs
      run_locally do
        fetch(:file_upload_dirs).each do |dir|
          unless test "[ -d #{dir} ]"
            error "Local dir '#{dir}' not found!"
            exit 1
          end
        end
      end
    end

    desc 'Check required files exists'
    task :files do
      next unless any? :file_upload_files
      run_locally do
        fetch(:file_upload_files).each do |file|
          unless test "[ -f #{file} ]"
            error "Local file '#{file}' not found!"
            exit 1
          end
        end
      end
    end
  end

  desc 'Remove existing files and dirs'
  task :remove do
    invoke 'file_upload:remove:dirs'
    invoke 'file_upload:remove:files'
  end

  namespace :remove do
    desc 'Remove existing dirs'
    task :dirs do
      next unless any? :file_upload_dirs
      on release_roles(fetch(:file_upload_roles)) do
        fetch(:file_upload_dirs).each do |dir|
          target = release_path.join(dir)
          execute :rm, '-rf', target if test "[ -d #{target} ]"
        end
      end
    end

    desc 'Remove existing files'
    task :files do
      next unless any? :file_upload_files
      on release_roles(fetch(:file_upload_roles)) do
        fetch(:file_upload_files).each do |file|
          target = release_path.join(file)
          execute :rm, target if test "[ -f #{target} ]"
        end
      end
    end
  end

  desc 'Upload data to server'
  task :upload do
    on release_roles(fetch(:file_upload_roles)) do
      fetch(:file_upload_dirs).each do |dir|
        upload! dir, File.join(release_path, dir), recursive: true
      end
      fetch(:file_upload_files).each do |file|
        upload! file, File.join(release_path, file)
      end
    end
  end

  desc 'Prepare and upload new data'
  task :run do
    invoke 'file_upload:remove'
    invoke 'file_upload:upload'
  end

  before 'deploy:started', 'file_upload:check'
  before 'deploy:updated', 'file_upload:run'
end

namespace :load do
  task :defaults do
    set :file_upload_dirs, []
    set :file_upload_files, []
    set :file_upload_roles, :all
  end
end
