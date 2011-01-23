class Runner < Qt::Process
  def initialize(main)
    super
    
    @main = main
    connect(SIGNAL(:readyReadStandardOutput), &method(:read_data))
  end

  def run(code = nil)
    code_file_name = "#{File.dirname(__FILE__)}/../../tmp/kidcode.rb"
    #save_kid_code(code, code_file_name)
    
    self.start("ruby #{code_file_name}")
  end

  def read_data
    @main.append(self.readAllStandardOutput())
  end
  
  def save_kid_code(code)
    codeFile = Qt::File.new(outputDir + "/" + header)
    if !codeFile.open(Qt::File::WriteOnly | Qt::File::Text)
        Qt::MessageBox.warning(self, tr("Simple Wizard"),
                               tr("Cannot write file %s:\n%s" %
                               [ codeFile.fileName(), codeFile.errorString() ] ) )
        return
    end

    code_block = code
    codeFile.write(code_block)
  end
end
