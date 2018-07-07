resize_doc_img_480px:
	find doc -name "*.png" | xargs -I{} sips -Z 480 {}
