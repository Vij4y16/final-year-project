<?php if ($fing == " "): ?>
    <h1 class="text-center redalert">Please regiter your finger print to cast your vote.</h1>

<?php else: ?>
	
    <script src="<?=base_url('assets/js/mfs100.js')?>"></script>
    <script language="javascript" type="text/javascript">
        var quality = 60; //(1 to 100) (recommanded minimum 55)
        var timeout = 10; // seconds (minimum=10(recommanded), maximum=60, unlimited=0 )
        var nooffinger = '1';
        function Capture() {
            try {

                var res = CaptureFinger(quality, timeout);
                if (res.httpStaus) {
                    if (res.data.ErrorCode == "0") {
                        document.getElementById('imgFinger').src = "data:image/bmp;base64," + res.data.BitmapData;
                    }
                }
                else {
                    Swal.fire('Failed', res.err, 'error');                
                }
            }
            catch (e) {
                Swal.fire('Failed', e.message, 'error'); 
            }
            return false;
        }

        function Match() {
            try {
                var isotemplate = '<?php echo $fing; ?>';
                var res = MatchFinger(quality, timeout, isotemplate);
                if (res.httpStaus) {
                    if (res.data.Status) {
                        Swal.fire('Success', 'Finger matched', 'success').then(() => {
                            sessionStorage.setItem("fingerverified", 1);
                            window.location.assign("http://localhost/voting-ci/");
                        });
                    }
                    else {
                        if (res.data.ErrorCode != "0") {
                            Swal.fire('Failed', res.data.ErrorDescription, 'error');
                            
                        }
                        else {
                            Swal.fire('Failed', 'Finger not matched', 'error').then(
                                () => {$("#btnCaptureAndMatch").text("Rescan");});
                            
                        }
                    }
                }
                else {
                    Swal.fire('Failed', res.err, 'error');
                }
            }
            catch (e) {
                Swal.fire('Failed', e.message, 'error');
            }
            return false;

        }        
    </script>


    <div class="tengah">
      <div class="col-sm-5">
        <div class="box box-success box-solid">
          <div class="box-header">
            <h4 class="box-title"><i class="fa fa-lock"></i> Voter's Login Panel</h4>
          </div>
          <div class="box-body">
            <h4 class="text-center text-muted">Please scan your finger to continue</h4>
            <div>
                <img src="<?=base_url('assets/img/scan-finger.gif')?>" id="imgFinger" alt="Finger Image" class='img'/>
            </div>
                <button onclick="return Match()" class="btn btn-success btn-flat btn-block" id="btnCaptureAndMatch">Scan and verify</button>
          </div>
        </div>
      </div>
    </div>
<?php endif ?>

<script>
	$('.logout').on('click', function(e){
      e.preventDefault()
      sessionStorage.setItem("mobilenoverified", 0);
      sessionStorage.setItem("fingerverified", 0);
      window.location.assign('<?=base_url("user/logout")?>');
    })
</script>