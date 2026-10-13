"""Read-only Windows window discovery and capture. No input APIs."""
import ctypes
from ctypes import wintypes as W

u = ctypes.WinDLL('user32', use_last_error=True)
CALLBACK = ctypes.WINFUNCTYPE(W.BOOL, W.HWND, W.LPARAM)
u.EnumWindows.argtypes = [CALLBACK, W.LPARAM]
u.IsWindowVisible.argtypes = [W.HWND]
u.IsWindow.argtypes = [W.HWND]
u.IsIconic.argtypes = [W.HWND]
u.GetWindowTextW.argtypes = [W.HWND, W.LPWSTR, ctypes.c_int]
u.GetClientRect.argtypes = [W.HWND, ctypes.POINTER(W.RECT)]
u.GetWindowRect.argtypes = [W.HWND, ctypes.POINTER(W.RECT)]
u.ClientToScreen.argtypes = [W.HWND, ctypes.POINTER(W.POINT)]
u.GetAncestor.argtypes = [W.HWND, W.UINT]
u.GetAncestor.restype = W.HWND


def dpi_aware():
    try:
        u.SetProcessDpiAwarenessContext(ctypes.c_void_p(-4))
    except (AttributeError, OSError):
        u.SetProcessDPIAware()


def windows():
    found = []
    @CALLBACK
    def visit(hwnd, _):
        title = ctypes.create_unicode_buffer(512)
        u.GetWindowTextW(hwnd, title, 512)
        if u.IsWindowVisible(hwnd) and any(t in title.value for t in ('造梦', '西游', 'Duskeye')):
            found.append((int(hwnd), title.value))
        return True
    u.EnumWindows(visit, 0)
    return found


def client_rect(hwnd):
    if not u.IsWindow(hwnd) or u.IsIconic(hwnd):
        raise ValueError('游戏已关闭或最小化，恢复窗口后会继续识别')
    r, p = W.RECT(), W.POINT()
    if not u.GetClientRect(hwnd, ctypes.byref(r)) or not u.ClientToScreen(hwnd, ctypes.byref(p)):
        raise ValueError('暂时无法读取游戏窗口')
    return p.x, p.y, p.x+r.right, p.y+r.bottom


def intersects(a, b):
    return a[0] < b[2] and b[0] < a[2] and a[1] < b[3] and b[1] < a[3]


def capture(hwnd, helper_hwnd=None):
    from PIL import ImageGrab
    rect = client_rect(hwnd)
    if helper_hwnd and not u.IsIconic(helper_hwnd):
        r = W.RECT()
        if u.GetWindowRect(helper_hwnd, ctypes.byref(r)) and intersects(rect, (r.left, r.top, r.right, r.bottom)):
            raise ValueError('请把游戏窗口缩小，将答案面板放在旁边，不要重叠')
    image = ImageGrab.grab(bbox=rect, all_screens=True)
    if rect != client_rect(hwnd):
        raise ValueError('窗口正在移动，稍后自动重试')
    return image
