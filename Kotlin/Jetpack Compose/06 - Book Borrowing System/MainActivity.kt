package com.example.w7bookborrowingsystem


import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.w7bookborrowingsystem.ui.theme.W7BookBorrowingSystemTheme


const val TAG = "BorrowingBookLifeCycle"
class MainActivity : ComponentActivity() {
   override fun onCreate(savedInstanceState: Bundle?) {
       super.onCreate(savedInstanceState)
       Log.d(TAG, "onCreate() called")
       setContent {
           W7BookBorrowingSystemTheme {
               borrowBookScreen(context = this@MainActivity)
           }
       }
   }
   override fun onStart() {
       super.onStart();
       Log.d(TAG, "onStart() called")
   }


   override fun onResume() {
       super.onResume();
       Log.d(TAG, "onResume() called")
   }


   override fun onPause() {
       super.onPause();
       Log.d(TAG, "onPause() called")
   }


   override fun onStop() {
       super.onStop();
       Log.d(TAG, "onStop() called")
   }


   override fun onDestroy() {
       super.onDestroy();
       Log.d(TAG, "onDestroy() called")
   }
}


@Composable
fun borrowBookScreen (context: Context) {


   var borrowerName by rememberSaveable() {
       mutableStateOf("")
   }


   var studentID by rememberSaveable() {
       mutableStateOf("")
   }


   var bookTitle by rememberSaveable() {
       mutableStateOf("")
   }


   var author by rememberSaveable() {
       mutableStateOf("")
   }
   Column(
       modifier = Modifier.fillMaxSize().padding(top = 200.dp),
       horizontalAlignment = Alignment.CenterHorizontally
   ) {
       Text(
           text = "BORROWING BOOK SYSTEM",
           fontSize = 35.sp,
           fontWeight = FontWeight.Bold);


       Spacer(modifier = Modifier.height(20.dp))


       OutlinedTextField(
           value = borrowerName,
           onValueChange = {borrowerName = it},
           label = { Text("Borrower Name") }
       )


       Spacer(modifier = Modifier.height(10.dp))


       OutlinedTextField(
           value = studentID,
           onValueChange = {studentID = it},
           label = { Text("Student ID") }
       )


       Spacer(modifier = Modifier.height(10.dp))


       OutlinedTextField(
           value = bookTitle,
           onValueChange = {bookTitle = it},
           label = { Text("Book Title") }
       )


       Spacer(modifier = Modifier.height(10.dp))


       OutlinedTextField(
           value = author,
           onValueChange = {author = it},
           label = { Text("Author") }
       )


       Spacer(modifier = Modifier.height(16.dp))


       Button(onClick = {
           val intent = Intent(context, BorrowingSummaryActivity::class.java)


           intent.putExtra("BORROWER_NAME", borrowerName)
           intent.putExtra("STUDENT_ID", studentID)
           intent.putExtra("BOOK_TITLE", bookTitle)
           intent.putExtra("AUTHOR", author)


           context.startActivity(intent)
       }) {
           Text("Borrow Book");
       }
   }
}
