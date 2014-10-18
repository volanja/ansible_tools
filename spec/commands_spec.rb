# coding: utf-8
require 'ansible_tools'
require 'yaml'

test_dir = "tmp"

describe "テスト" do
  before(:all) do
    $stdout = File.open("/dev/null", "w") #テスト実行中は標準出力は/dev/nullにする。
  end

  after(:all) do
    $stdout =STDOUT # テスト実行後は元に戻す
  end

  # テスト実行前
  before(:each) do
    FileUtils.mkdir_p(test_dir) unless FileTest.exist?(test_dir)
    Dir.chdir(test_dir) #tmp/に移動
  end

  # テスト実行後
  after(:each) do
    Dir.chdir("../")
    FileUtils.rm_rf(test_dir, :secure => true)
  end

  # ディレクトリの存在をチェックする。
  def expect_dir_exist(array)
    array.each{|d|
      expect(File.directory?(d)).to be_truthy
    }
  end
  # ファイルの存在をチェックする。
  def expect_file_exist(array)
    array.each{|f|
      expect(FileTest.exist?(f)).to be_truthy
    }
  end

  #YAMLファイルをロードする。
  def load_yaml(path)
    yaml = File.open( File.dirname(__FILE__) + path).read
    return YAML.load(yaml)
  end

  it "init(yml-only = false)" do
    AnsibleTools.init(false)
    yaml = load_yaml("/lists/init_false.yml")
    expect_file_exist(yaml["file"])
    expect_dir_exist(yaml["dir"])
  end

  it "init(yml-only = true)" do
    AnsibleTools.init(true)
    yaml = load_yaml("/lists/init_true.yml")
    expect_file_exist(yaml["file"])
    expect_dir_exist(yaml["dir"])
  end

end
