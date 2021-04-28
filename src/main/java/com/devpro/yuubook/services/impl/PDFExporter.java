package com.devpro.yuubook.services.impl;

import com.devpro.yuubook.models.entities.Order;
import com.devpro.yuubook.models.entities.OrderDetail;
import com.devpro.yuubook.utils.FuncUtils;
import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;

public class PDFExporter {
    private Order order;

    public PDFExporter(Order order) {
        this.order = order;
    }

    private void writeTableHeader(PdfPTable table) {
        PdfPCell cell = new PdfPCell();
        cell.setPadding(5);
        Font font = FontFactory.getFont(FontFactory.HELVETICA);

        cell.setPhrase(new Phrase("San Pham", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Anh", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("So luong", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Don gia", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Thanh tien", font));
        table.addCell(cell);
    }

    private void writeTableData(PdfPTable table) throws IOException {
        for (OrderDetail item : order.getOrderDetails()) {
            table.addCell(item.getBook().getName());
            table.addCell(getImage(item.getBook().getAvatar()));
            table.addCell(item.getQuantity() + "");
            table.addCell(FuncUtils.formatPrice(Double.parseDouble(item.getUnitPrice() + "")));
            table.addCell(FuncUtils.formatPrice(Double.parseDouble
                    (item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())) + "")));
        }
    }

    private PdfPCell getImage(String fileName) throws IOException {
        File root = new File("/home/linhnv/Documents/School/Yuubook-springboot/upload/products/");
        Image image = Image.getInstance(new File(root, fileName.substring(fileName.indexOf("/") + 1)).getAbsolutePath());

        image.setWidthPercentage(2);
        image.scaleAbsolute(45, 60);
        image.setAbsolutePosition(50, 50);
        return new PdfPCell(image);
    }

    public void exportPDF(HttpServletResponse response) throws IOException {
        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();

        Font font = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
        font.setSize(18);

        Paragraph p = new Paragraph("DANH SACH SAN PHAM", font);
        p.setAlignment(Paragraph.ALIGN_CENTER);

        document.add(p);

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100f);
        table.setWidths(new float[]{5f, 2.0f, 1.0f, 1.8f, 1.8f});
        table.setSpacingBefore(10);

        writeTableHeader(table);
        writeTableData(table);
        writeContent();
        document.add(table);
        document.close();
    }

    private void writeContent() {
    }
}
