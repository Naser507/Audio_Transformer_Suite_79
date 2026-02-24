#include <windows.h>  
// This includes the main Windows API header file.
// It gives us access to all the Windows-specific data types,
// constants, and functions such as CreateWindowEx, RegisterClass,
// HWND, MSG, WM_DESTROY, etc.


LRESULT CALLBACK WindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
// This is the Window Procedure (message handler).
// Windows calls this function automatically whenever something
// happens to our window (like clicking, closing, resizing, etc.).
//
// LRESULT  -> The return type (a long integer result returned to Windows)
// CALLBACK -> A macro that ensures the correct calling convention
// hwnd     -> Handle to the window receiving the message
// uMsg     -> The message identifier (what event occurred)
// wParam   -> Additional message-specific information
// lParam   -> Additional message-specific information
{
    switch (uMsg)  // We check which message was sent to the window
    {
        case WM_DESTROY:
            // WM_DESTROY is sent when the window is being destroyed
            // (for example, when the user clicks the close button).

            PostQuitMessage(0);
            // This tells Windows to exit the message loop.
            // The 0 is the exit code (0 usually means "successful exit").

            return 0;
            // Return 0 to tell Windows we handled this message.
    }

    return DefWindowProc(hwnd, uMsg, wParam, lParam);
    // If we did NOT handle the message above,
    // we pass it to the default Windows handler.
    // This allows Windows to perform normal behaviors like:
    // moving, resizing, minimizing, painting, etc.
}


int WINAPI wWinMain(HINSTANCE hInstance, HINSTANCE, PWSTR, int nCmdShow)
// This is the entry point for a Windows GUI application.
// Instead of using main(), Windows GUI apps use wWinMain().
//
// int        -> Return type (exit code)
// WINAPI     -> Calling convention required by Windows
// hInstance  -> Handle to this running instance of the application
// second HINSTANCE -> Legacy parameter (unused)
// PWSTR      -> Pointer to command-line arguments (unused here)
// nCmdShow   -> Controls how the window should be shown (normal, minimized, etc.)
{
    const wchar_t CLASS_NAME[] = L"ATS79WindowClass";
    // This defines a unique name for our window class.
    // Windows requires that every window belongs to a registered class.
    // The L before the string makes it a wide-character (Unicode) string.


    WNDCLASS wc = {};
    // Create a WNDCLASS structure.
    // This structure holds information about our window type.
    // = {} initializes all fields to zero (important for safety).


    wc.lpfnWndProc = WindowProc;
    // Set the pointer to our Window Procedure function.
    // This connects our message handler to this window class.


    wc.hInstance = hInstance;
    // Assign the application instance handle to this window class.
    // This tells Windows which program owns this window.


    wc.lpszClassName = CLASS_NAME;
    // Assign the class name we defined earlier.
    // This name will be used later when creating the window.


    RegisterClass(&wc);
    // Register the window class with Windows.
    // After this call, Windows knows how to create windows of this type.


    HWND hwnd = CreateWindowEx(
        0,                          // Extended window styles (0 = none)
        CLASS_NAME,                 // Name of the registered window class
        L"Audio Transformer Suite 79", // The window title (shown in title bar)
        WS_OVERLAPPEDWINDOW,        // Window style (standard resizable window)
        CW_USEDEFAULT, CW_USEDEFAULT, // Default X and Y screen position
        1000, 700,                  // Width and height of the window
        NULL,                       // Parent window (NULL = no parent)
        NULL,                       // Menu handle (NULL = no menu)
        hInstance,                  // Application instance handle
        NULL                        // Additional application data (none)
    );
    // CreateWindowEx actually creates the window on the system.
    // It returns a handle (HWND) that represents the window.


    if (hwnd == NULL)
        return 0;
    // If window creation failed, hwnd will be NULL.
    // In that case, exit the program immediately.


    ShowWindow(hwnd, nCmdShow);
    // This makes the window visible on the screen.
    // Until this function is called, the window exists but is hidden.


    MSG msg = {};
    // Create a MSG structure.
    // This structure will store messages retrieved from the message queue.
    // = {} initializes it to zero.


    while (GetMessage(&msg, NULL, 0, 0))
    {
        // GetMessage retrieves messages sent to our application.
        // It blocks (waits) until a message arrives.
        //
        // &msg -> pointer to the MSG structure that receives the message
        // NULL -> receive messages for any window in this thread
        // 0,0  -> receive all message types
        //
        // When GetMessage returns:
        // > 0  -> continue running
        // 0    -> WM_QUIT received (exit loop)
        // -1   -> error


        TranslateMessage(&msg);
        // Converts virtual-key messages into character messages.
        // This is mainly for proper keyboard input handling.


        DispatchMessage(&msg);
        // Sends the message to the WindowProc function.
        // This is how our WindowProc receives events.
    }


    return 0;
    // Return 0 to the operating system.
    // This signals that the program exited successfully.
}
