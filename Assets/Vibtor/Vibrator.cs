using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

public static class Vibrator 
{
    public static bool canRun = true;
#if UNITY_ANDROID
    private static AndroidJavaClass v = new AndroidJavaClass("com.unity.vibrator.Vibrator");
#elif UNITY_IOS
    [DllImport("__Internal")]
    static extern void _Virbite(int time, float inty);
#endif
    /// <summary>
    /// 立即震动
    /// </summary>
    /// <param name="time">震动时长（ms）</param>
    public static void Vibrate(long time, float inf = 1)
    {
        if (!canRun) return;
#if UNITY_EDITOR
#elif UNITY_ANDROID
        v.CallStatic("vibrate", time.ToString());
#elif UNITY_IOS
        _Virbite((int)time, inf);
#endif
    }
//    /// <summary>
//    /// 按波形震动
//    /// </summary>
//    /// <param name="times">震动的波形，用毫秒表示 如:[100,100,100,100] 表示 停止0.1s震动0.1s,反复两次</param>
//    /// <param name="repeat">-1 为不重复，0 为一直重复振动， 1 则是指从数组中下标为1的地方开始重复振动（不是振动一次！！！），2 从数组中下标为2的地方开始重复振动。以此类推</param>
//    public static void Vibrate(long[] times,int repeat)
//    {
//        if (!canRun) return;
//#if UNITY_ANDROID
//        v.CallStatic("vibrate", "", times, repeat);
//#endif
//    }
    /// <summary>
    /// 停止震动
    /// </summary>
    public static void Cancel()
    {
#if UNITY_ANDROID
        v.CallStatic("cancel", "");
#endif
    }
}
