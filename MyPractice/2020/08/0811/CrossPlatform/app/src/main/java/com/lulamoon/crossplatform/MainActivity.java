package com.lulamoon.crossplatform;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;

public class MainActivity extends AppCompatActivity
{

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        WebView mWebView = (WebView) findViewById(R.id.browser);
        WebSettings webSettings = mWebView.getSettings();
        //
        webSettings.setJavaScriptEnabled(true);

        webSettings.setJavaScriptCanOpenWindowsAutomatically(true);

        WebChromeClient ChromeClient;
        ChromeClient = new WebChromeClient();

        mWebView.setWebChromeClient(ChromeClient);

        mWebView.loadUrl("https://www.apple.com");
    }
}