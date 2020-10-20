# require "pdf_split/version"
require 'vips'
require 'hexapdf'
# require 'pry'


module PdfSplit
  class PdfSplit
    attr_reader :width, :height, :path

    def initialize(project_path)
      @path = project_path  #string타입...
      split_pdf
      make_folder
      # make_jpg(ratio: 2)
      self
    end

    def split_pdf
      original_pdf_files = []
      original_pdf_file = Dir.glob("#{@path}/*.pdf").first
      doc     = HexaPDF::Document.open(original_pdf_file)
      page    = doc.pages.first
      @width  = page.box.width
      @height = page.box.height
      pdf_file_name = File.basename(original_pdf_file)
      system("cd #{@path} && hexapdf split #{pdf_file_name}")
    end

    def make_folder
      Dir.glob("#{@path}/*").each do |f|
        if f =~/_\d\d\d\d.pdf$/
          with_pdf_ext = f.split("_").last            #0123.pdf
          dirname = with_pdf_ext.split(".").first     #0123
          system("cd #{@path} && mkdir #{dirname}") #unless File.exist?(dirname)      
          system("cd #{@path} && mv #{f} #{dirname}/#{with_pdf_ext}") # mv   full_path/0123.pdf  0123/0123.pdf
        end
      end
    end

    def make_jpg(options={})                                                             # path = File.dirname(__FILE__)
      Dir.glob("#{@path}/**/*.pdf").each do |f|
        next unless f =~/\d\d\d\d.pdf$/ # skip original pdf
        if options[:ratio]
          convert_pdf2jpg(f, options[:ratio])
        elsif  f =~ /.pdf$/
          jpg_path = full_path.sub(/pdf$/, 'jpg')
          im = Vips::Image.new_from_file full_path
          im = im.resize 2
          im.write_to_file jpg_path
        end
      end
    end

    # using vips convert pdf 2 jpg
    # if enlarging ratio is given as options, it enlarges pdf canvas to the given ratio, 
    # then generates jpg, giving the hi-resolution result
    def convert_pdf2jpg(output_path, ratio)
      @pdf_folder = File.dirname(output_path)
      enlarged_path = output_path.gsub(/.pdf$/, "_enlarged.pdf")
      target = HexaPDF::Document.new
      src =  HexaPDF::Document.open(output_path)
      src.pages.each do |page|
        form = target.import(page.to_form_xobject)
        width = form.box.width * ratio
        height = form.box.height * ratio
        canvas = target.pages.add([0, 0, width, height]).canvas
        canvas.xobject(form, at: [0, 0], width: width, height: height)
      end
      target.write(enlarged_path, optimize: true)
      @enlarged_pdf_base_name = File.basename(enlarged_path)
      @jpg_base_name = File.basename(output_path).gsub(/.pdf$/, ".jpg")
      commend  = "cd #{@pdf_folder} && vips copy #{@enlarged_pdf_base_name}[n=-1] #{@jpg_base_name}"
      system(commend)
      system("rm #{enlarged_path}")
    end

  end
end
