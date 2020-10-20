require_relative 'pdf_split'

require 'minitest/autorun'

describe "test pdf sp;it" do
  before do
    @project_path = "/Users/mskim/Development/PDF_Books/ajax/test_book"
    @pdf = PdfSplit::PdfSplit.new(@project_path)

  end
  it 'should create pdf files' do
    assert_equal @pdf.class, PdfSplit::PdfSplit
  end

end
