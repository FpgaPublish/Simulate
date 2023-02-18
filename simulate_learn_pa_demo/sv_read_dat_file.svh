class SvReadDatFile;
// ==============================================
// variables 
integer dat_fifo[2048];
// ==========================================================
// function
extern function new(); 
extern function integer read_dat(string n_dat);

endclass // SV_READ_DAT
// ######################################################################
// function exec
function SvReadDatFile::new();
begin
    integer i;
    for(i = 0; i < 2048; i = i + 1)
    begin
        dat_fifo[i] = 0;
    end
end
endfunction
function integer SvReadDatFile::read_dat(string n_dat);
begin
    integer i;
    integer dat;
    integer err;
    integer len;
    string  str;
    integer fd;
    i   = 0;
    err = 0;
    fd = $fopen(n_dat,"r");
    $fseek(fd,0,0);
    while(!$feof(fd))
    begin
        err = $fscanf(fd,"%d\n",dat);
        if(err == 0 || err == -1)
        begin
            $display("current dat = %d",dat);
            err = $fgets(str, fd);
        end
        else 
        begin
            if(i == 0)
            begin
                if(dat != 1) //not dat form
                begin
                    return -1;
                end
            end
            else if(i == 1)
            begin
                len = dat;
            end
            else 
            begin
                dat_fifo[i-2] = dat;
            end
            i = i + 1;
        end 
    end
    $fclose(fd);
    return len;
end
endfunction

// ######################################################################
// simple use
program use_sv_read_dat_file;
SvReadDatFile f_dat;
integer len;

initial 
begin
    f_dat = new();
    len = f_dat.read_dat("sin.dat");
end
integer i = 0;
integer r_sin = 0;
initial 
begin
    repeat(len + 1)
    begin
        #10
        r_sin = f_dat.dat_fifo[i];
        i     = (i < len) ? i + 1 : 0;
    end
    $stop();
end

endprogram
