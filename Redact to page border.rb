$markupName='Credit Card'



currentCase.getMarkupSets().each do | markup |
	if(markup.getName()==$markupName)
		items=currentCase.searchUnsorted('markup-set:"' + markup.getName() + '"')
		puts "full Width Redaction Started for #{items.size} for markup:#{$markupName}"
		items.each do | item |
			item.getPrintedImage.getPages().each do | page |
				markupAnnotations=page.getMarkups(markup)
				markupAnnotations.each do | markupAnnotation |
					if(markupAnnotation.getWidth() < markupAnnotation.getHeight())
						#landscape
						item.addTag("Markup|landscape")
						markupAnnotation.setBounds(markupAnnotation.getX(),0,markupAnnotation.getWidth(), 1)
					else
						#portrait
						item.addTag("Markup|portrait")
						markupAnnotation.setBounds(0,markupAnnotation.getY(), 1, markupAnnotation.getHeight())
					end
				end
			end
		end
	end
end