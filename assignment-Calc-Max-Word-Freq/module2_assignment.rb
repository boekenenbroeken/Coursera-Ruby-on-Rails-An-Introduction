class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number

    calculate_word_frequency()
  end

  def calculate_word_frequency()
    test = Hash.new(0)

    @content.split.each do |word|
      test[word.downcase] += 1
    end
    
    @highest_wf_count = test.map{ |word, count| count}.max
    @highest_wf_words = test.reject{ |key, value| value != @highest_wf_count}.map{ |word, count| word}
  end
end

class Solution
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
  
  def initialize()
    @analyzers = Array.new
    @highest_count_words_across_lines = nil
  end

  def analyze_file() 
    if File.exist?('test.txt')
      File.foreach("test.txt").with_index do |line, line_num|
         @analyzers.push(LineAnalyzer.new(line.downcase(), line_num))
      end
    end
  end 

  def calculate_line_with_highest_frequency() 
    @highest_count_across_lines = @analyzers.map(&:highest_wf_count).max
    @highest_count_words_across_lines = []


    @analyzers.each do |line|
      @highest_count_words_across_lines << line if line.highest_wf_count == @highest_count_across_lines
    end

  end

  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"

    @highest_count_words_across_lines.each do |analyzer| 
      puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})"
    end
  end
end
