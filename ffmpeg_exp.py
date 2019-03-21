# coding=utf-8
'''
example of how to read string of video and output as string
'''
import sys, subprocess

def create_pipe():
    return subprocess.Popen([
        'ffmpeg',
        '-loglevel', 'panic',
        '-skip_frame', 'nokey',
        '-i','-',
        '-vsync', '0',
        '-c:v', 'bmp',
        '-f', 'image2pipe',
        '-an',
        '-'
    ], stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=10**8)


def main(video_path):
    in_pipe = create_pipe()

    content = open(video_path, "rb").read()
    print("write content to stdin: ", len(content))
    out, err = in_pipe.communicate(input=content)

    in_pipe.wait()
    pdb.set_trace()
    

if __name__ == "__main__":
    video_path = sys.argv[1]
    main(video_path)
