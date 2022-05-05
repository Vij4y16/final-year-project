<?php if ($sname): ?>
<div class="tengah">
  <div class="col-sm-5">
    <div class="box box-success box-solid">
      <div class="box-header">
        <h4 class="box-title"><i class="fa fa-lock"></i> Voter's Login Panel</h4>
      </div>
      <div class="box-body">
        <h4 class="text-center text-muted">Please enter OTP continue</h4>
        	<p class="text-center greenalert" id="otptext">Click the below button to send OTP to your registered mobile number +91<?php echo $sname; ?></p>
        	<button onclick="phoneAuth();" class="btn btn-success btn-flat btn-block" id="sign-in-button">Send OTP</button>
          <div class="form-group">
            <label for="Username">OTP :</label>
            <input type="text" name="username" class="form-control" placeholder="Enter OTP" id="verificationcode">
          </div>
          <button onclick="codeverify();" class="btn btn-success btn-flat btn-block">Verify</button>
        
      </div>
    </div>
  </div>
</div>
<script src="https://www.gstatic.com/firebasejs/8.6.7/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.6.7/firebase-auth.js"></script>

<script> 
    var firebaseConfig = {
		    apiKey: "AIzaSyBUmyjK3X1SqHBfvdLgAxRha7P97yw4fxM",
			  apiKey: "AIzaSyDkFqy-b0mxCEZkA-FMqgmgddV-1r70jzE",
			  authDomain: "online-voting-27.firebaseapp.com",
			  projectId: "online-voting-27",
			  storageBucket: "online-voting-27.appspot.com",
			  messagingSenderId: "942586729363",
			  appId: "1:942586729363:web:05bc530a3f7c9ea8824e66"
		};

	firebase.initializeApp(firebaseConfig);

	window.onload=function() {
		try {
		render();
		}
		catch(err) {
			console.log(err.message);
		}
	}

	function render() {
		try {
			window.recaptchaVerifier = new firebase.auth.RecaptchaVerifier('sign-in-button', {
			  'size': 'invisible',
			  'callback': (response) => {
			    // reCAPTCHA solved, allow signInWithPhoneNumber.
			    onSignInSubmit();
			  }
			});
			recaptchaVerifier.render();
			}
			catch(err) {
				console.log(err.message);
			}
	}
	var phnno;
	function phoneAuth() {
			if (<?php echo $sname; ?> !== '') {
				phnno = <?php echo $sname; ?>
			} else {
				phnno = '0000000000';
			}
			firebase.auth().signInWithPhoneNumber("+91"+<?php echo $sname; ?>, window.recaptchaVerifier)
		    .then((confirmationResult) => {
		      // SMS sent. Prompt user to type the code from the message, then sign the
		      // user in with confirmationResult.confirm(code).
		      window.confirmationResult = confirmationResult;
		      alert("Message Sent!");
		      $("#otptext").text("Click the below button to resend the OTP to your registered mobile number +91<?php echo $sname; ?>");
		      document.getElementById("otptext").className = "text-center yellowalert";
		      $("#sign-in-button").text("Resend OTP");
		    }).catch((error) => {
		      $("#otptext").text(error.message);
	      	document.getElementById("otptext").className = "text-center redalert";
		    });
	}

	function codeverify() {
		var coder = {
			code: $('#verificationcode').val()
		};

		confirmationResult.confirm(coder.code).then((result) => {
		  const user = result.user;

		  console.log(user);
			localStorage.setItem("verified", 1);
		  window.location.assign("http://localhost/voting-ci/");	
		}).catch((error) => {
	  		alert("Entered OTP is incorrect, Please check the OTP!");
		});
	}
</script>
<?php else: ?>
	<h1 class="text-center redalert">Please regiter your mobile number to cast your vote.</h1>
<?php endif ?>

<script>
	$('.logout').on('click', function(e){
      e.preventDefault()
      localStorage.setItem("verified", 0);
      window.location.assign('http://localhost/voting-ci/user/logout');
    })
</script>