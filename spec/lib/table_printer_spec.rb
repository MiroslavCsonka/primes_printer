require "./spec/spec_helper"
require "./lib/table_printer"

describe TablePrinter do

  def prints(content, options={})
    TablePrinter.new(content, options).print
  end

  it "prints empty content" do
    expect(prints([])).to eq ""
  end

  it "prints single value" do
    expect(prints([[1]])).to eq "  1"
  end

  it "prints whole row" do
    expect(prints([[1, 2, 3, 4]])).to eq "  1  2  3  4"
  end

  it "prints multiple rows" do
    expect(prints([[1, 2, 3, 4], [5, 6, 7, 8]])).to eq "  1  2  3  4\n  5  6  7  8"
  end

  it "prints with heading" do
    expect(prints([], heading: ["Some", "Cool", "Heading"])).to eq "  Some  Cool  Heading\n----------------------"
  end

  it "does not print side heading without data" do
    expect(prints([], side_heading: ["First row heading", "Second row heading"])).to eq ""
  end

  it "prints with heading with content" do
    expect(prints([[1, 2, 3]], heading: ["Some", "Cool", "Heading"])).to eq "  Some  Cool  Heading\n----------------------\n     1     2        3"
  end

  it "prints with side heading without primeprinter horizontal heading" do
    table = prints([[1, 2, 3]], side_heading: ["Some"])
    expect(table).to eq "Some|  1  2  3"
  end

  it "prints multiple rows with both headings" do
    expect(prints([[1, 2, 3, 4], [5, 6, 7, 8]], heading: [1, 2, 3, 4], side_heading: [1, 2, 3, 4])).to eq "   |  1  2  3  4\n---+------------\n  1|  1  2  3  4\n  2|  5  6  7  8"
  end

  it "prints with extra spaces" do
    expect(prints([[1, 2]], extra_spaces: 5)).to eq "     1     2"
  end

end