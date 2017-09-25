create or replace package body PLDPF_EXAMPLES is

/* INIT_EXAMPLE */
procedure InitDefault is
  l_blob blob;
begin
  
    plpdf.Init;
    
    /* Create a new page. Without parameters the default page orientation: portrait. */
    plpdf.NewPage();
    
    /* Sets the font properties */
    plpdf.SetPrintFont(
    p_family => 'Arial', -- Font family: Arial
    p_style  => null, -- Font style: Regular
    p_size   => 12 -- Font size: 12
    );
    
    --add text
    plpdf.PrintText(
    p_x => 20,
    p_y => 30,
    p_txt => 'PLPDF Barcode Example'
    );
    -- add text
    plpdf.PrintText(
    p_x => 20,
    p_y => 60,
    p_txt => 'Barcode Example using Code39 Method'
    );
    
    plpdf_barcode.Code39(
    20, -- p_x number,   X coordinate for the top left corner of the barcode
    40, -- p_y number,   Y coordinate for the top left corner of the barcode
    'E150305', -- p_code varchar2,  Value of the barcode.
    1, -- p_basewidth number,  Width of a bar.
    10, -- p_height number,    Height of a bar.
    0 -- p_gap number default 0
    );
    
    plpdf.SetPrintFont(
    p_family => 'Arial',               -- Font family: Arial
    p_style => 'B',                    -- Font style: Regular
    p_size => 22                         -- Font size: 72
    );
    
    
    plpdf.SetColor4Text(
    p_r => 0,           -- Red component code. Number between 0 and 255
    p_g => 191,           -- Green component code. Number between 0 and 255
    p_b => 255            -- Blue component code. Number between 0 and 255
    );  
    
    plpdf.SetCurrentXY(
    p_x => 40,          -- X coordinate
    p_y => 90           -- Y coordinate
    ); 
  
   plpdf.PrintCell(
   p_w => 100,         -- Rectangle width
   p_h => 15,          -- Rectangle height
   p_txt => 'zCon Solutions Pvt.Limited',-- Text in rectangle
   p_border  => '1',
   p_ln  =>0,
   p_align =>'Center',
   p_fill  => 0,
   p_link => null,
   p_clipping =>1
   );


  /* Returns the generated PDF document.
  The document is closed and then returned in the OUT parameter. */
  plpdf.SendDoc(
    p_blob => l_blob -- The generated document
    );

  /* store in table */
  insert into STORE_BLOB (blob_file, created_date, filename) VALUES (l_blob,sysdate, 'MyBarCodeExample');
  commit;

end;
end PLDPF_EXAMPLES;
