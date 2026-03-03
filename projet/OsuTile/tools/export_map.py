import os
import sys
import re


def parse_osu_file(path, lane_count=3):
    notes = []
    with open(path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    hit_objects_started = False
    for line in lines:
        line = line.strip()
        if line == "[HitObjects]":
            hit_objects_started = True
            continue
        if hit_objects_started:
            if not line:
                continue
            parts = line.split(",")
            if len(parts) < 3:
                continue
            x = int(parts[0])
            time = int(parts[2])
            # osu!mania: 512px width divided equally per lane
            lane = min(x * lane_count // 512, lane_count - 1)
            notes.append((lane, time))
    return notes


def export_to_py(notes, out_path):
    with open(out_path, "w") as f:
        f.write("beatmap = [\n")
        for lane, time in notes:
            f.write(f"    ({lane}, {time}),\n")
        f.write("]\n")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python export_map.py <input.osu> <output.py>")
        sys.exit(1)

    input_path = sys.argv[1]
    output_path = sys.argv[2]

    notes = parse_osu_file(input_path)
    export_to_py(notes, output_path)
    print(f"✅ Exported {len(notes)} notes to {output_path}")
