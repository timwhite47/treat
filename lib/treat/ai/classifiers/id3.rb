class Treat::AI::Classifiers::ID3
  
  require 'decisiontree'
  
  @@classifiers = {}
  
  def self.classify(entity, options = {})
  
    set = options[:training]
    cl = set.classification
    
    if !@@classifiers[cl]
      dec_tree = DecisionTree::ID3Tree.new(
      set.labels.map { |l| l.to_s }, set.items, 
      cl.default, :continuous)
      dec_tree.train
    else
      dec_tree = @@classifiers[cl]
    end
    
    cl.export_item(entity, false).inspect
    
    dec_tree.predict(
      cl.export_item(entity, false)
    )[0]
    
  end
  
end