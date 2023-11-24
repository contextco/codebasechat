
class Clone

  FILE = Struct.new(:path, :content)

  def initialize(repo)
    @repo = repo
    @randomdir = SecureRandom.hex(RANDOM_LENGTH)
    @directory = File.join(ENV.fetch('REPOS_BASE_PATH', Rails.root.join('tmp')), @randomdir)
  end

  def file_from_repo
    files = generate_files

    combine_files(files)
  end

  private

  RANDOM_LENGTH = 10

  def combine_files(files)
    f = StringIO.new

    files.each do |file|
      f << "## #{file.path}\n\n"
      f << "```\n"
      f << file.content
      f << "```\n\n\n"
    end

    f.rewind
    f
  end

  def generate_files
    repo = Git.clone(@repo, @directory)

    readme = nil
    files = []

    # Iterate through all files in the repository
    Dir.glob(File.join(@directory, '**', '*')).each do |file|
      next if File.directory?(file)
      next unless allowed_extensions.include?(File.extname(file))

      if File.basename(file).downcase == 'readme.md'
        readme = FILE.new(file.delete_prefix(@randomdir), File.read(file))
        next
      end

      files << FILE.new(file.delete_prefix(@randomdir), File.read(file))
    end

    files.prepend(readme) if readme

    FileUtils.rm_rf(@directory)

    files
  end

  def allowed_extensions
    %w(.py .js .html .css .java .c .cpp .cs .php .rb .go .rs .ts .swift .kt .lua .pl .sh .sql .json .md)
  end
end