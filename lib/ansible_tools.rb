require "ansible_tools/version"
require "fileutils"

module AnsibleTools

  # command ansible-init
  def self.init()
    simple = safe_list_simple('common')
    complex = safe_list_complex()
    # dir
    simple[:dir].each { |dir| safe_mkdir(dir) }
    complex[:dir].each { |dir| safe_mkdir(dir) }
    # file
    simple[:file].each { |file| safe_touch(file) }
    complex[:file].each { |file| safe_touch(file) }

  end
  
  # command ansible-init simple
  def self.init_simple()
    simple = safe_list_simple('common')
    # dir
    simple[:dir].each { |dir| safe_mkdir(dir) }
    # file
    simple[:file].each { |file| safe_touch(file) }
  end

  def self.safe_list_simple(role)
    dir = Array.new
    dir_role = "roles/#{role}"
    tasks = "#{dir_role}/tasks"
    handlers =  "#{dir_role}/handlers"
    templates = "#{dir_role}/templates"
    vars = "#{dir_role}/vars"
    files = "#{dir_role}/file"
    dir = [tasks,handlers,templates,vars,files]

    file = Array.new
    site = 'site.yml'
    f_task = "#{tasks}/main.yml"
    f_handlers = "#{handlers}/main.yml"
    f_templates = "#{templates}/foo.conf.j2"
    f_vars = "#{vars}/main.yml"
    f_file = "#{files}/bar.txt"
    file = [site,f_task,f_handlers,f_templates, f_vars, f_file]
    return {:dir => dir, :file => file}
  end

  def self.safe_list_complex()
    dir = Array.new
    group = 'group_var'
    host = 'host_var'
    dir = [group, host]
    file = ["production", "stage", "#{group}/group1", "#{group}/group2", "#{host}/hostname1", "#{host}/hostname2"]
    return {:dir => dir, :file => file}
  end
  
  def self.safe_mkdir(dir)
    unless FileTest.exist?("#{dir}")
      FileUtils.mkdir_p("#{dir}")
      TermColor.green
      puts "\t\tcreate\t#{dir}"
      TermColor.reset
    else
      TermColor.red
      puts "\t\texists\t#{dir}"
      TermColor.reset
    end
  end

  def self.safe_touch(file)
    unless File.exists? "#{file}"
      File.open("#{file}", 'w') do |f|
          #f.puts content
      end
      TermColor.green
      puts "\t\tcreate\t#{file}"
      TermColor.reset
    else 
      TermColor.red
      puts "\t\texists\t#{file}"
      TermColor.reset
    end
  end

  class TermColor
    class << self
      # 色を解除
      def reset   ; c 0 ; end 
  
      # 各色
      def red     ; c 31; end 
      def green   ; c 32; end 
  
      # カラーシーケンスを出力する
      def c(num)
        print "\e[#{num.to_s}m"
      end 
    end 
  end

end
