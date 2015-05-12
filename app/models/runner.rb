class Runner < Qt::Process
  def initialize(main)
    super
    @main_widget = main

    connect(self, SIGNAL('finished(int, QProcess::ExitStatus)'),
        @main_widget, SLOT('runnerFinished(int, QProcess::ExitStatus)'))
  end

  def run(code = default_code, code_file_name = default_kid_code_location)
    kill unless state == NotRunning
    save_kid_code(code, code_file_name)
    start("ruby #{code_file_name}")
  end

  def stop
    kill if state == Running
  end

  def save_kid_code(code, code_file_name)
    codeFile = Qt::File.new(code_file_name)
    if !codeFile.open(Qt::File::WriteOnly | Qt::File::Text)
        Qt::MessageBox::warning(nil, tr("KidsRuby Problem"),
                               tr("Oh, uh! Cannot write file %s:\n%s" %
                               [ codeFile.fileName(), codeFile.errorString() ] ) )
        return
    end

    codeFile.write(build_code_from_fragment(code))
    codeFile.close()
  end

  def build_code_from_fragment(code)
    # add any default requires for kid code
    new_code = "# -*- coding: utf-8 -*-\n"
    new_code << "require '" + File.expand_path(File.dirname(__FILE__) + "/../../lib/kidsruby") + "'\n"
    new_code << code
    new_code
  end

  def default_code
    'puts "No code entered"'
  end

  def default_kid_code_location
    "#{tmp_dir}/kidcode.rb"
  end

  def tmp_dir
    Qt::Dir::tempPath.force_encoding "utf-8"
  end
end
