module videoGen(
    input logic [9:0] x, y,
    output logic [7:0] r, g, b
);
    logic inrect_main, inrect_secondary;
    
    parameter size = 10'd56;
    parameter frame = 10'd4;
    
	 parameter size_secondary = 10'd28;
	 
	 
    int colIndex_main, rowIndex_main, col_px_main, row_px_main;
    int colIndex_secondary, rowIndex_secondary, col_px_secondary, row_px_secondary;
    
    assign colIndex_main = (x-60) / (size+frame);
    assign rowIndex_main = (y-30) / (size+frame);
    
    assign col_px_main = colIndex_main*(size+frame) + 60;
    assign row_px_main = rowIndex_main*(size+frame) + 30;
    
    
	 
	 assign inrect_main = (colIndex_main < 1 && rowIndex_main < 1) && (x >= col_px_main && x < col_px_main+size && y >= row_px_main && y < row_px_main+size);
    
    
	 
	 assign colIndex_secondary = (x - 420) / (size_secondary+frame);
    assign rowIndex_secondary = (y - 300) / (size_secondary+frame);
    
    assign col_px_secondary = colIndex_secondary*(size_secondary+frame) + 420;
    assign row_px_secondary = rowIndex_secondary*(size_secondary+frame) + 300;
    
    assign inrect_secondary = (colIndex_secondary < 1 && rowIndex_secondary < 1) && (x >= col_px_secondary && x < col_px_secondary+size_secondary && y >= row_px_secondary && y < row_px_secondary+size_secondary);
    
	  assign {r, g, b} = inrect_main ? {8'hFF, 8'h00, 8'h00} :
                        inrect_secondary ? {8'h00, 8'h00, 8'hFF} :
                        {8'h00, 8'h00, 8'h00};


endmodule
