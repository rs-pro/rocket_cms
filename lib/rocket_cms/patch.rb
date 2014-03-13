module RocketCMS
  class PatchDSL
    def self.call(&blk)
      instance = new
      instance.instance_eval(&blk)
      instance.instance_variables.inject({}) { |result_hash, instance_variable|
        result_hash[instance_variable[1..-1].to_sym] = instance.instance_variable_get(instance_variable)
        result_hash
      }
    end
    
    def initialize
      @model  = Proc.new {}
      @admin  = Proc.new {}
      @list   = Proc.new {}
      @show   = Proc.new {}
      @edit   = Proc.new {}
      @export = Proc.new {}
    end
    
    def model(&blk);  @model = blk;  end
    def admin(&blk);  @admin = blk;  end
    def list(&blk);   @list = blk;   end
    def show(&blk);   @show = blk;   end
    def edit(&blk);   @edit = blk;   end
    def export(&blk); @export = blk; end
  end
  
  @@patches = {}
  
  def self.only_patches(s, sections)
    s.instance_eval do
      sections.each do |section|
        send section do
          RocketCMS.apply_patches self
        end
      end
    end
  end
  
  def self.apply_patches(s)
    if s.class.name.index('RailsAdmin::Config::Sections::').nil?
      if s.class.name == 'RailsAdmin::Config::Model'
        s.instance_eval(&@@patches[s.abstract_model.model_name][:admin]) unless @@patches[s.abstract_model.model_name].nil?
      else
        s.instance_eval(&@@patches[s.name][:model]) unless @@patches[s.name].nil?
      end
    else
      model = s.abstract_model.model_name
      action = s.class.name.split('::')[-1].downcase.to_sym
      s.instance_eval(&@@patches[model][action]) unless @@patches[model].nil?
    end
  end
  
  def self.patch(model, &blk)
     @@patches[model] = PatchDSL.call(&blk)
  end
end
