## Dcm4chee

Dcm4chee是一个[Rails
Engine](http://api.rubyonrails.org/classes/Rails/Engine.html),为[Dcm4chee](http://www.dcm4chee.org)提供基于RESTful的Web APIs。

### 安装说明

在Gemfile中添加dcm4chee：

```ruby
gem 'dcm4chee'
```

执行`bundle install`安装。

### 开发说明

#### 查看文档

```bash
# 生成项目文档
yardoc

# 启动文档服务器
yard server

# 通过浏览器查看文档，http://localhost:8808
```

#### 单元测试

```bash
bundle exec rspec

# Or
bundle exec rake spec
```
