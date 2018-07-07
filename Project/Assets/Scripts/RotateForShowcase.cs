using System.Collections;
using UnityEngine;

public class RotateForShowcase : MonoBehaviour
{
    public float Delay = 1;
    public float RotateSpeed = 180;

    public Transform Light;
    public Transform Model;

    IEnumerator Start()
    {
        while (true)
        {
            yield return new WaitForSeconds(Delay);
            yield return Rotate(Light);
            yield return new WaitForSeconds(Delay);
            yield return Rotate(Model);
        }
    }

    IEnumerator Rotate(Transform target)
    {
        var duration = 360 / RotateSpeed;
        while (duration > 0)
        {
            var dt = Time.deltaTime;
            duration -= dt;
            if (duration < 0)
                dt += duration;
            target.RotateAround(Vector3.zero, Vector3.up, dt * RotateSpeed);
            yield return null;
        }
    }
}