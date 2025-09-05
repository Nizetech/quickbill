import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:math';
import 'package:jost_pay_wallet/service/account_repo.dart';

class BankTransferScreen extends StatefulWidget {
  final double? amount;
  const BankTransferScreen({super.key, this.amount});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
  bool isLoading = true;
  bool isProcessing = false;
  WebViewController? controller;
  final AccountRepo _accountRepo = AccountRepo();

  // Payment data
  late String reference;
  late double amount;
  late Map<String, dynamic> userData;

  // OnePipe configuration - replace with actual values from your OnePipe dashboard
  static const String onepipeApiKey = "your_onepipe_api_key_here";
  static const bool isProduction = false; // Set to true for production

  @override
  void initState() {
    super.initState();
    _initializePaymentData();
    _setupWebView();
  }

  void _initializePaymentData() {
    // Generate unique reference
    reference = _generateReference();

    // Get amount from widget or use default
    amount = widget.amount ?? 1000.0;

    // Get actual user data - replace with your actual user data retrieval
    _loadUserData();
  }

  void _loadUserData() {
    // TODO: Replace this with actual user data from your app
    // Example: Get from SharedPreferences, Provider, or API
    setState(() {
      userData = {
        'first_name': 'John', // Replace with actual user first name
        'last_name': 'Doe', // Replace with actual user last name
        'email': 'john.doe@example.com', // Replace with actual user email
        'phone': '+2348012345678' // Replace with actual user phone
      };
    });
  }

  static String _generateReference() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final randomChars = String.fromCharCodes(Iterable.generate(
        6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    return 'JOST$timestamp$randomChars';
  }

  void _setupWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });

            // Handle payment completion
            if (url.contains('success') || url.contains('completed')) {
              _handlePaymentSuccess();
            } else if (url.contains('failed') || url.contains('error')) {
              _handlePaymentError('Payment was not completed successfully');
            }

            // Check if OnePipe script loaded successfully
            _checkOnePipeScriptLoaded();
          },
          onHttpError: (HttpResponseError error) {
            _handlePaymentError('HTTP Error occurred');
          },
          onWebResourceError: (WebResourceError error) {
            _handlePaymentError('Web Error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('Navigation Request: ${request.url}');

            // Handle OnePipe callback URLs
            if (request.url.contains('onepipe.com/callback')) {
              _handleOnePipeCallback(request.url);
              return NavigationDecision.prevent;
            }

            // Handle success/failure redirects
            if (request.url.contains('success') ||
                request.url.contains('completed')) {
              _handlePaymentSuccess();
              return NavigationDecision.prevent;
            }

            if (request.url.contains('failed') ||
                request.url.contains('error')) {
              _handlePaymentError('Payment failed');
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString(_generateOnePipeHTML());
  }

  void _checkOnePipeScriptLoaded() async {
    try {
      // Check if OnePipe script is loaded
      final result = await controller?.runJavaScriptReturningResult(
          'typeof OnePipe !== "undefined" ? "loaded" : "not_loaded"');

      if (result == 'not_loaded') {
        // Retry loading the script
        await Future.delayed(const Duration(seconds: 2));
        await controller?.runJavaScript('''
          if (typeof OnePipe === "undefined") {
            var script = document.createElement('script');
            script.src = 'https://js.paygateplus.ng/v2';
            script.onload = function() { console.log('OnePipe script loaded via retry'); };
            script.onerror = function() { console.error('Failed to load OnePipe script'); };
            document.head.appendChild(script);
          }
        ''');
      }
    } catch (e) {
      debugPrint('Error checking OnePipe script: $e');
    }
  }

  String _generateOnePipeHTML() {
    final ref = reference;
    final amt = amount.toStringAsFixed(2);

    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OnePipe Bank Transfer</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .logo {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            font-weight: bold;
        }
        .payment-details {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            border: 1px solid #e9ecef;
        }
        .amount {
            font-size: 32px;
            font-weight: bold;
            background: linear-gradient(135deg, #28a745, #20c997);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
            margin: 25px 0;
        }
        .btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 18px 30px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            margin: 15px 0;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }
        .btn:disabled {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        .status {
            text-align: center;
            margin: 20px 0;
            padding: 20px;
            border-radius: 12px;
            font-weight: 500;
        }
        .success { 
            background: linear-gradient(135deg, #d4edda, #c3e6cb); 
            color: #155724; 
            border: 1px solid #c3e6cb;
        }
        .error { 
            background: linear-gradient(135deg, #f8d7da, #f5c6cb); 
            color: #721c24; 
            border: 1px solid #f5c6cb;
        }
        .info { 
            background: linear-gradient(135deg, #d1ecf1, #bee5eb); 
            color: #0c5460; 
            border: 1px solid #bee5eb;
        }
        .processing {
            background: linear-gradient(135deg, #fff3cd, #ffeaa7);
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        .reference {
            background: #e9ecef;
            padding: 10px 15px;
            border-radius: 8px;
            font-family: monospace;
            font-size: 14px;
            color: #495057;
            text-align: center;
            margin: 15px 0;
        }
        #onepipe-container {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="logo">₦</div>
            <h1>Bank Transfer</h1>
            <p>Complete your payment securely</p>
        </div>
        
        <div class="payment-details">
            <h3>Payment Details</h3>
            <div class="reference">
                <strong>Reference:</strong> $ref
            </div>
            <p><strong>Amount:</strong> ₦$amt</p>
            <p><strong>Description:</strong> Bank Transfer to JostPay</p>
        </div>
        
        <div class="amount">
            ₦$amt
        </div>
        
        <button id="payButton" class="btn" onclick="initiateOnePipePayment()">
            Proceed to Payment
        </button>
        
        <div id="status" class="status info" style="display: none;">
            Loading OnePipe payment gateway...
        </div>
        
        <div id="onepipe-container"></div>
    </div>

    <!-- Load OnePipe Payment Gateway Script -->
    <script src="https://js.paygateplus.ng/v2"></script>
    
    <script>
        let onePipeInstance = null;
        let paymentInProgress = false;
        
        function initiateOnePipePayment() {
            if (paymentInProgress) return;
            
            const payButton = document.getElementById('payButton');
            const status = document.getElementById('status');
            const container = document.getElementById('onepipe-container');
            
            paymentInProgress = true;
            payButton.disabled = true;
            payButton.textContent = 'Loading...';
            status.style.display = 'block';
            status.className = 'status processing';
            status.textContent = 'Initializing OnePipe payment gateway...';
            
            // Wait for OnePipe script to load
            if (typeof OnePipe === 'undefined') {
                setTimeout(initiateOnePipePayment, 500);
                return;
            }
            
            try {
                // Configure OnePipe payment
                const onePipeConfig = {
                    id: 'jostpay-bank-transfer-' + Date.now(),
                    requestData: {
                        request_ref: '$ref',
                        request_type: 'collect',
                        auth: null,
                        api_key: '$onepipeApiKey', // Replace with actual API key
                        transaction: {
                            amount: $amt * 100, // Convert to kobo (smallest currency unit)
                            transaction_ref: '$ref',
                            transaction_desc: 'Bank Transfer to JostPay',
                            ${isProduction ? '' : 'mock_mode: "inspect",'}
                            customer: {
                                customer_ref: '$ref',
                                firstname: '${userData['first_name']}',
                                surname: '${userData['last_name']}',
                                email: '${userData['email']}',
                                mobile_no: '${userData['phone']}'
                            },
                            meta: {
                                currency: 'NGN',
                                referrer: window.location.href
                            },
                            details: null,
                        },
                    },
                    callback: function(response) {
                        console.log('OnePipe Response:', response);
                        
                        let message = (response.message || response.data?.message || ''),
                            status = response.status,
                            data = response.data;

                        if (data?.error) {
                            let error_message = data.error.message || "Transaction failed.";
                            handlePaymentError(error_message);
                        } else if (status && status !== 'failed') {
                            handlePaymentSuccess(response);
                        } else {
                            handlePaymentError("We were unable to confirm your deposit. Please try again");
                        }
                    },
                    onClose: function() {
                        console.log("OnePipe payment popup closed.");
                        paymentInProgress = false;
                        payButton.disabled = false;
                        payButton.textContent = 'Proceed to Payment';
                        status.style.display = 'none';
                    }
                };
                
                // Initialize OnePipe
                onePipeInstance = new OnePipe(onePipeConfig);
                
                status.className = 'status info';
                status.textContent = 'Payment gateway ready. Click to proceed.';
                
                // Execute payment
                onePipeInstance.execute();
                
            } catch (error) {
                console.error('OnePipe Error:', error);
                handlePaymentError('Failed to initialize payment gateway: ' + error.message);
            }
        }
        
        function handlePaymentSuccess(response) {
            const status = document.getElementById('status');
            const payButton = document.getElementById('payButton');
            
            status.className = 'status success';
            status.textContent = 'Payment successful! Processing...';
            
            // Send success message to Flutter
            if (window.flutter_inappwebview) {
                window.flutter_inappwebview.callHandler('paymentSuccess', {
                    reference: '$ref',
                    amount: $amt,
                    status: 'success',
                    response: response
                });
            }
            
            // Redirect to success URL after a delay
            setTimeout(() => {
                window.location.href = 'https://api.getairtop.com/success?ref=$ref&amount=$amt';
            }, 2000);
        }
        
        function handlePaymentError(message) {
            const status = document.getElementById('status');
            const payButton = document.getElementById('payButton');
            
            status.className = 'status error';
            status.textContent = message || 'Payment failed. Please try again.';
            
            payButton.disabled = false;
            payButton.textContent = 'Retry Payment';
            paymentInProgress = false;
        }
        
        // Listen for messages from Flutter
        window.addEventListener('message', function(event) {
            if (event.data.type === 'payment') {
                if (event.data.status === 'success') {
                    handlePaymentSuccess(event.data);
                } else {
                    handlePaymentError(event.data.message);
                }
            }
        });
        
        // Handle page visibility change
        document.addEventListener('visibilitychange', function() {
            if (document.hidden && paymentInProgress) {
                console.log('Payment processing in background...');
            }
        });
        
        // Check if OnePipe script loaded successfully
        window.addEventListener('load', function() {
            if (typeof OnePipe === 'undefined') {
                console.warn('OnePipe script not loaded. Retrying...');
                setTimeout(() => {
                    if (typeof OnePipe === 'undefined') {
                        handlePaymentError('Payment gateway failed to load. Please refresh and try again.');
                    }
                }, 3000);
            }
        });
    </script>
</body>
</html>
    ''';
  }

  void _handlePaymentSuccess() async {
    try {
      setState(() {
        isProcessing = true;
      });

      // Create deposit record
      final depositData = {
        'amount': amount.toString(),
        'reference': reference,
        'type': 'bank_transfer',
        'status': 'completed',
        'description': 'Bank Transfer via OnePipe'
      };

      final response = await _accountRepo.createDeposit(depositData);

      if (response['status'] == 'success') {
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Payment successful! ₦${amount.toStringAsFixed(2)} has been added to your balance.'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate back
          Navigator.pop(context);
        }
      } else {
        _handlePaymentError(
            'Failed to update balance. Please contact support.');
      }
    } catch (e) {
      _handlePaymentError('Error processing payment: $e');
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  void _handlePaymentError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleOnePipeCallback(String url) {
    // Parse OnePipe callback and handle accordingly
    try {
      final uri = Uri.parse(url);
      final status = uri.queryParameters['status'];
      final message = uri.queryParameters['message'];

      if (status == 'success') {
        _handlePaymentSuccess();
      } else {
        _handlePaymentError(message ?? 'Payment failed');
      }
    } catch (e) {
      _handlePaymentError('Error processing callback: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final dashProvider = Provider.of<DashboardProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: controller!),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: MyColor.greenColor,
                ),
              ),
            if (isProcessing)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: MyColor.greenColor,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Processing payment...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              child: Container(
                height: 68,
                width: double.infinity,
                color: themeProvider.isDarkMode()
                    ? MyColor.dark01Color
                    : MyColor.mainWhiteColor,
                child: Row(
                  children: [
                    Transform.translate(
                      offset: const Offset(10, -8),
                      child: BackBtn(
                        onTap: () {
                          dashProvider.changeBottomIndex(4);
                        },
                      ),
                    ),
                    const Spacer(flex: 2),
                    Text(
                      "Bank Transfer",
                      style: TextStyle(
                        color: themeProvider.isDarkMode()
                            ? MyColor.mainWhiteColor
                            : MyColor.dark01Color,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
