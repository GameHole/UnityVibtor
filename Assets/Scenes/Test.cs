using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Test : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        GetComponent<Button>().onClick.AddListener(() =>
        {
            Vibrator.Vibrate(3000, 1);
        });   
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
