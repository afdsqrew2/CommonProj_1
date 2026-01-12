using UnityEngine;

public class PathAnimFunc : MonoBehaviour
{
    public Vector3[] points;
    public float speed = 1.0f; // 移动速度
    public float leftTime2Fly2NextTarget;
    public float resetFixedFlyTime = 3;
    public int nextPointIndex = 0;
    void Start()
    {
        leftTime2Fly2NextTarget = resetFixedFlyTime;
    }

    void Update()
    {
        leftTime2Fly2NextTarget-=Time.deltaTime;
        if(leftTime2Fly2NextTarget<0)
        {
            leftTime2Fly2NextTarget = resetFixedFlyTime;
            nextPointIndex++;
            if (nextPointIndex >= points.Length)
            {
                nextPointIndex = 0;
            }
        }
        transform.position = Vector3.Lerp(transform.position, points[nextPointIndex], speed * Time.deltaTime);
    }
} // 使用Lerp平滑移动到新