# coding: utf-8
require 'ansible_tools'

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
    array["created_dir"].each{|d|
      expect(File.directory?(d)).to be_truthy
    }
  end
  # ファイルの存在をチェックする。
  def expect_file_exist(array)
    array["created_file"].each{|f|
      expect(FileTest.exist?(f)).to be_truthy
    }
  end

  it "init(yml-only = false)" do
    AnsibleTools.init(false)
    array = init_false
    expect_file_exist(array)
    expect_dir_exist(array)
  end

  it "init(yml-only = true)" do
    AnsibleTools.init(true)
    array = init_true
    expect_file_exist(array)
    expect_dir_exist(array)
  end

  def init_false
    res = Hash.new
    res["created_file"] = [
      "group_vars",
      "host_vars",
      "site.yml",
      "roles/common/tasks/main.yml",
      "roles/common/handlers/main.yml",
      "roles/common/templates/foo.conf.j2",
      "roles/common/vars/main.yml",
      "roles/common/files/bar.txt",
      "production",
      "stage",
      "group_vars/group1",
      "group_vars/group2",
      "host_vars/hostname1",
      "host_vars/hostname2"
    ]
    res["created_dir"] = [
      "roles",
      "roles/common",
      "roles/common/tasks",
      "roles/common/handlers",
      "roles/common/templates",
      "roles/common/vars",
      "roles/common/files",
      "group_vars",
      "host_vars",
    ]
    return res
  end

  def init_true
    res = Hash.new
    res["created_file"] = [
      "group_vars",
      "host_vars",
      "site.yml",
      "roles/common/tasks/main.yml",
      "roles/common/handlers/main.yml",
      "roles/common/vars/main.yml",
    ]
    res["created_dir"] = [
      "roles",
      "roles/common",
      "roles/common/tasks",
      "roles/common/handlers",
      "roles/common/templates",
      "roles/common/vars",
      "roles/common/files",
    ]
    return res
  end
end
