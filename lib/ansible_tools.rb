require "ansible_tools/version"
require "fileutils"
require "yaml"
require 'ruport'

module AnsibleTools

  # command ansible-tools init
  def self.init(yml_only)
    simple = yml_only ? safe_list_yml_only('common') : safe_list_simple('common')
    complex = safe_list_complex()
    # dir
    simple[:dir].each { |dir| safe_mkdir(dir) }
    complex[:dir].each { |dir| safe_mkdir(dir) }
    # file
    simple[:file].each { |file| safe_touch(file) }
    complex[:file].each { |file| safe_touch(file) } unless yml_only

  end

  # command ansible-tools init -s
  def self.init_simple(yml_only)
    simple = yml_only ? safe_list_yml_only('common') : safe_list_simple('common')
    # dir
    simple[:dir].each { |dir| safe_mkdir(dir) }
    # file
    simple[:file].each { |file| safe_touch(file) }
  end

  # command ansible-tools init -r <rolename>
  def self.init_role(name, yml_only)
    role = yml_only ? safe_list_yml_only("#{name}") : safe_list_simple("#{name}")
    # dir
    role[:dir].each { |dir| safe_mkdir(dir) }
    # file
    role[:file].each { |file| safe_touch(file) }
  end

  def self.safe_list_simple(role)
    dir = Array.new
    dir_role = "roles/#{role}"
    tasks = "#{dir_role}/tasks"
    handlers =  "#{dir_role}/handlers"
    templates = "#{dir_role}/templates"
    vars = "#{dir_role}/vars"
    files = "#{dir_role}/files"
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

  def self.safe_list_yml_only(role)
    dir = Array.new
    dir_role = "roles/#{role}"
    tasks = "#{dir_role}/tasks"
    handlers =  "#{dir_role}/handlers"
    templates = "#{dir_role}/templates"
    vars = "#{dir_role}/vars"
    files = "#{dir_role}/files"
    dir = [tasks,handlers,templates,vars,files]

    file = Array.new
    site = 'site.yml'
    f_task = "#{tasks}/main.yml"
    f_handlers = "#{handlers}/main.yml"
    f_vars = "#{vars}/main.yml"
    file = [site,f_task,f_handlers, f_vars]
    return {:dir => dir, :file => file}
  end


  def self.safe_list_complex()
    dir = Array.new
    group = 'group_vars'
    host = 'host_vars'
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

  # command ansible-tools show
  def self.show()
    begin
      if Dir.glob("**/vars/*").count == 0
        puts 'Not Found'
        exit 1
      end
      table = Ruport::Data::Table.new
      table.column_names = %w[File Key Value]

      # search *.yml
      Dir.glob("*.yml") {|f|
        next unless FileTest.file?(f) #skip directory
        yml = YAML.load_file(f)
        if yml == false
          puts "No Variables in #{f}"
          next
        end
        yml.each{|h|
          if h.instance_of?(Hash) && h.has_key?("vars") 
            h["vars"].each{|key,value|
              table << [f,key,value]
            }
          end
        }
      }
      # search */*.yml e.g. group_vars, host_vars
      Dir.glob("*/*.yml") {|f|
        next unless FileTest.file?(f) #skip directory
        yml = YAML.load_file(f)
        if yml == false
          puts "No Variables in #{f}"
          next
        end
        yml.each{|key,value|
          table << [f,key,value]
        }
      }
      # search roles/*/vars/*.yml
      Dir.glob("**/vars/*") {|f|
        next unless FileTest.file?(f) #skip directory
        yml = YAML.load_file(f)
        if yml == false
          puts "No Variables in #{f}"
          next
        end
        yml.each{|key,value|
          table << [f,key,value]
        }
      }
      if table.count > 0
        puts table.to_text
      end
    rescue => e
      puts e
      fail 'Sorry. Error hanppend..'
    end
  end

  class TermColor
    class << self
      # 色を解除
      def reset   ; c 0 ; end

      # 各色
      def red     ; c 31; end
      def green   ; c 32; end

      # カラーシーケンスの出力
      def c(num)
        print "\e[#{num.to_s}m"
      end
    end
  end

end
