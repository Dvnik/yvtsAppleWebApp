package com.lulamoon.cross2;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.webkit.WebChromeClient;
import android.webkit.WebView;

public class MainActivity extends AppCompatActivity
{
    private WebView map;
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


    }

    @Override
    protected void onStart() {
        super.onStart();
    }

    @Override
    protected void onResume() {
        super.onResume();

        map = (WebView) this.findViewById(R.id.map);
        map.getSettings().setJavaScriptEnabled(true);

        WebChromeClient myWebViewClient = new WebChromeClient();
        map.setWebChromeClient(myWebViewClient);
        map.loadUrl("https://bussiness-acaca.firebaseapp.com/cross2.html");
    }
}