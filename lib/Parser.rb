class Parser
  def initialize(array=nil)
    @array = array
	@array.unshift("dummy") if @array 
  end
  def hasMoreCommands
    !@array.nil? and @array.size > 1 
  end
  def advance
  	@array.shift
  	self
  end
  def commandType 
  	if(@array[0].start_with?("@"))
  		return "A_COMMAND"
  	else
  		return "C_COMMAND"
  	end
  end
  def symbol
  	@array[0].gsub("@", "")

  end
  def dest
  	match = @array[0].match(/(.+)=/)
  	match[1] if match 
  end
  def comp

  end
end

raise "default parser should not have any commands" if Parser.new().hasMoreCommands == true

raise "parser with data should have commands" if Parser.new(['@7','D=M']).hasMoreCommands == false

raise "parser with two commands should have more " if Parser.new(['@7', 'D=M']).advance.advance.hasMoreCommands == true

raise "parser should recognize A command" unless Parser.new(['@7']).advance.commandType == "A_COMMAND"

raise "parser should recognize C command" unless Parser.new(['D=M']).advance.commandType == "C_COMMAND"

raise "parser should recognize symbol for A command" unless Parser.new(['@7']).advance.symbol == "7"

raise "parser should return destination mnemonic" unless Parser.new(['D=M']).advance.dest == "D" 

raise "parser should gracefully handle null destination" unless Parser.new(['M']).advance.dest == nil

raie "parser should return compare mnemonic" unless Parser.new([''])

puts "Tests pass"

