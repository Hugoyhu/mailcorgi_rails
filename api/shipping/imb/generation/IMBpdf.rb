
require 'usps_intelligent_barcode'
require 'prawn'
require 'rails'

class IMBpdf
  # a function that can be called later. no return, generates a PDF file stored to a predefined folder. 3x1 thermal
  def self.createLabel(
    id, type, mailer, serial, routing, name,
    addrL1, addrL2, addrL3
  )
    barcode = Imb::Barcode.new(id,
                               type,
                               mailer,
                               serial,
                               routing)

    imbFontDir = "imb/fonts/USPSIMBStandard.ttf"
    textFontDir = "imb/fonts/PhantomSans0.8-Regular.ttf"

    saveDir = "imb/files/"

    pdfName = saveDir + mailer + "_" + serial + ".pdf"

    # create PDF document with IMb, Name, Address
    Prawn::Document.generate(

      pdfName,
      page_size: [72, 216],
      page_layout: :landscape,
      margin: 6
    ) do |pdf|

      pdf.font_size 12

      pdf.font textFontDir

      nameSpacing = 40
      l1Spacing = 28
      l3Spacing = 16

      # if there is Address Line 2, text will be compressed a bit to fit it.
      if addrL2 != ''

        pdf.font_size 12
        pdf.move_cursor_to 26
        pdf.text addrL2

        nameSpacing = 46
        l1Spacing = 36
        l3Spacing = 16

      end

      pdf.font textFontDir

      pdf.move_cursor_to nameSpacing
      pdf.text name

      pdf.move_cursor_to l1Spacing
      pdf.text addrL1



      pdf.move_cursor_to l3Spacing
      pdf.text addrL3

      pdf.font_size 16

      pdf.move_cursor_to 60

      # print out previusly created barcode string with the IMb font. Point 16 recommended by USPS for Standard font.
      pdf.font imbFontDir
      pdf.text barcode.barcode_letters

      p barcode.barcode_letters



    end
  end
end