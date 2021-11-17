def nested_get(input_dict, nested_key):
    dict_value = input_dict
    for k in nested_key:
        dict_value = dict_value.get(k, None)
        if dict_value is None:
            return None
    return dict_value

print(nested_get({"a":{"b":{"c":"d"}}},["a","b","c"]))
print(nested_get({"x":{"y":{"z":"a"}}},["x","y","z"])) 