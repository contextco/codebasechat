
class Clone

  FILE = Struct.new(:path, :content)

  def initialize(repo)
    @repo = repo
    @directory = SecureRandom.hex(RANDOM_LENGTH)
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
      f << "## #{file.path}\n"
      f << "```"
      f << file.content
      f << "```\n"
    end

    f.rewind
    f
  end

  def generate_files
    repo = Git.clone(@repo, destination)

    files = []

    # Iterate through all files in the repository
    Dir.glob(File.join(destination, '**', '*')).each do |file|
      next if File.directory?(file)
      next unless allowed_extensions.include?(File.extname(file))

      files << FILE.new(file[RANDOM_LENGTH..], File.read(file))
    end

    # FileUtils.rm_rf(@destination)

    files
  end

  def destination
    File.join(Rails.root, 'tmp', @directory)
  end

  def allowed_extensions
    %w(.py .js .html .css .java .c .cpp .cs .php .rb .go .rs .ts .swift .kt .lua .pl .sh .sql .json)
  end
end