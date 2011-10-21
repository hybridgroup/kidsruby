# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# Add files and commands to this file, like the example:
#   watch('file/path') { `command(s)` }
#
guard 'shell' do
  watch(%r{app/}) { restart_kidsruby }
  watch(%r{lib/}) { restart_kidsruby }
  watch(%r{public/}) { restart_kidsruby }
  watch('main.rb') { restart_kidsruby }

  def restart_kidsruby
    stop_kidsruby 
    start_kidsruby
  end

  def stop_kidsruby
    kill_kidsruby
    cleanup_pid_file
  end

  def kill_kidsruby
    Process.kill("HUP", pid.to_i)
  end

  def cleanup_pid_file
    File.delete(pid_file) if File.exists?(pid_file)
  end

  def start_kidsruby
    store_pid(kidsruby_process)
  end

  def store_pid(process)
    File.open(pid_file, 'w+') { |f| f.puts process.pid }
  end

  def kidsruby_process
    IO.popen('ruby main.rb', 'r')
  end

  def pid
    File.read(pid_file) if File.exists?(pid_file)
  end

  def pid_file
    './tmp/kidsruby.pid'
  end

  at_exit { cleanup_pid_file }
end
