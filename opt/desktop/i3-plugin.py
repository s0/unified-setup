#!/usr/bin/env python3

import i3ipc

# Create the Connection object that can be used to send commands and subscribe
# to events.
i3 = i3ipc.Connection()

output_numbers = {}

def generate_output_number(output):
    if output.name not in output_numbers:
        output_numbers[output.name] = len(output_numbers) + 1
    return output_numbers[output.name]

def wrap_workspace_name(output, name):
    number = generate_output_number(output)
    if number == 1:
        return name + '-'
    elif number == 2:
        return name + '~'
    else:
        return name + '~(' + str(number) + ')'

def get_current_output_id():
    current_ws = i3.get_tree().find_focused().workspace().name
    for output in i3.get_outputs():
        if output.current_workspace == current_ws:
            return output

def on_binding(event, data):
    if data.binding.command.startswith('exec echo m-workspace '):
        ws = data.binding.command[22:]
        output = get_current_output_id()
        if output:
            name = wrap_workspace_name(output, ws)
            i3.command('workspace ' + name)
        else:
            i3.command('workspace ' + ws)
    if data.binding.command.startswith('exec echo m-container '):
        ws = data.binding.command[22:]
        output = get_current_output_id()
        if output:
            name = wrap_workspace_name(output, ws)
            i3.command('move container to workspace ' + name)
        else:
            i3.command('move container to workspace ' + ws)

# Move to workspace 1 in each output
for output in filter(lambda o: o.active, i3.get_outputs()):
    i3.command('workspace ' + output.current_workspace)
    i3.command('workspace ' + wrap_workspace_name(output, '1'))

# Subscribe to events
i3.on('binding', on_binding)

# Start the main loop and wait for events to come in.
i3.main()
