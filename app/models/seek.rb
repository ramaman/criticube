class Seek

  def self.main(q_param, options={})
    Sunspot.search User, Cube do |query|
      query.fulltext q_param, :fields => [:name, :page_name]
      if options[:paginate]
        query.paginate :page => options[:paginate][:page], :per_page => options[:paginate][:per_page]
      end
    end
  end

end